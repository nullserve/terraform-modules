package domain

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func Test_DoesCreate(t *testing.T) {
	t.Parallel()

	tfOptions := &terraform.Options{
		TerraformDir: "./",
		Vars: map[string]interface{}{
			"domain":  "aws.0srv.co",
			"backend": "aws",
		},
	}

	defer terraform.Destroy(t, tfOptions)
	terraform.InitAndApply(t, tfOptions)
}
