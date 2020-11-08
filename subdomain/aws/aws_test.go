package aws

import (
	"testing"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/route53"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func Test_DoesNotCreate(t *testing.T) {
	// Setup
	sess, err := session.NewSession(aws.NewConfig())
	if err != nil {
		t.Errorf("cannot create session: %s", err)
	}

	r53 := route53.New(sess)
	rootHostedZone, err := r53.CreateHostedZone(&route53.CreateHostedZoneInput{
		Name: aws.String("0srv.co"),
	})
	if err != nil {
		t.Errorf("cannot create hosted zone: %s", err)
	}
	defer r53.DeleteHostedZone(&route53.DeleteHostedZoneInput{
		Id: rootHostedZone.HostedZone.Id,
	})

	// Test
	tfOptions := &terraform.Options{
		TerraformDir: "./",
		Vars: map[string]interface{}{
			"domain": "aws.0srv.co",
		},
	}

	defer terraform.Destroy(t, tfOptions)
	terraform.InitAndApply(t, tfOptions)

	// Teardown
}

func Test_DoesCreate(t *testing.T) {

	tfOptions := &terraform.Options{
		TerraformDir: "./",
		Vars: map[string]interface{}{
			"domain":        "aws.0srv.co",
			"should_create": true,
		},
	}

	defer terraform.Destroy(t, tfOptions)
	terraform.InitAndApply(t, tfOptions)
}
