package aws

import (
	"testing"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/route53"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

type TestingT struct {
	GinkgoTInterface
	desc GinkgoTestDescription
}

func NewTestingT() TestingT {
	return TestingT{GinkgoT(), CurrentGinkgoTestDescription()}
}

func (i TestingT) Helper() {

}
func (i TestingT) Name() string {
	return i.desc.FullTestText
}

var _ = Describe("AWS Subdomain", func() {
	var t TestingT

	BeforeSuite(func() {
		t = NewTestingT()
	})

	Context("when a root hosted zone exists", func() {
		sess, err := session.NewSession(aws.NewConfig())
		if err != nil {
			t.Errorf("cannot create session: %s", err)
		}

		r53 := route53.New(sess)
		rootHostedZone, err := r53.CreateHostedZone(&route53.CreateHostedZoneInput{
			CallerReference: aws.String(random.UniqueId()),
			Name:            aws.String("0srv.co"),
		})
		if err != nil {
			t.Errorf("cannot create hosted zone: %s", err)
		}

		It("creates expected resources", func() {
			tfOptions := &terraform.Options{
				TerraformDir: "./",
				Vars: map[string]interface{}{
					"domain_zone":      *rootHostedZone.HostedZone.Name,
					"name":             "aws.0srv.co subdomain",
					"should_create":    true,
					"subdomain_prefix": "aws",
				},
			}

			defer terraform.Destroy(t, tfOptions)
			terraform.InitAndApply(t, tfOptions)
			defer r53.DeleteHostedZone(&route53.DeleteHostedZoneInput{
				Id: rootHostedZone.HostedZone.Id,
			})
		})
	})
})

func TestAWS(t *testing.T) {

	RegisterFailHandler(Fail)
	RunSpecs(t, "AWS Subdomain Test Suite")
}
