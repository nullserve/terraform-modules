package aws

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func Test_DoesNotCreate(t *testing.T) {
	t.Parallel()

	tfOptions := &terraform.Options{
		TerraformDir: "./",
		Vars:         map[string]interface{}{},
	}

	defer terraform.Destroy(t, tfOptions)
	terraform.InitAndApply(t, tfOptions)
}

func Test_DoesCreate(t *testing.T) {
	t.Parallel()

	tfOptions := &terraform.Options{
		TerraformDir: "./",
		Vars: map[string]interface{}{
			"should_create": true,
		},
	}

	defer terraform.Destroy(t, tfOptions)
	terraform.InitAndApply(t, tfOptions)
}
