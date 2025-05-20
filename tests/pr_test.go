// Tests in this file are run in the PR pipeline
package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const customExampleTerraformDir = "examples/custom"
const templateExampleDir = "examples/account-settings-template"

func setupOptions(t *testing.T, terraformDir string, prefix string) *testhelper.TestOptions {
	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: terraformDir,
		Prefix:       prefix,
		// Do not hard fail the test if the implicit destroy steps fail to allow a full destroy of resource to occur
		ImplicitRequired: false,
	})

	return options
}

func setupTemplateOptions(t *testing.T, terraformDir string, prefix string) *testhelper.TestOptions {

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: terraformDir,
		Prefix:       prefix,
	})
	terraformVars := map[string]interface{}{
		"prefix": options.Prefix,
		// Workaround for provider bug https://github.com/IBM-Cloud/terraform-provider-ibm/issues/6216
		"account_group_ids_to_assign": []string{},
	}
	options.TerraformVars = terraformVars
	return options
}

func TestRunCustomExample(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, customExampleTerraformDir, "iam-act-cus")

	options.TerraformVars = map[string]interface{}{
		"prefix": options.Prefix,
	}

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunTemplateExample(t *testing.T) {
	t.Parallel()

	options := setupTemplateOptions(t, templateExampleDir, "as-template")

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunTemplateUpgrade(t *testing.T) {

	options := setupTemplateOptions(t, templateExampleDir, "template-upg")
	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
