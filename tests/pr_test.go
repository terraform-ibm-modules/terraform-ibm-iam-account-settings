// Tests in this file are run in the PR pipeline
package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const customExampleTerraformDir = "examples/custom"
const submoduleExampleTerraformDir = "examples/submodule"

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

func TestRunCustomExample(t *testing.T) {
	options := setupOptions(t, customExampleTerraformDir, "iam-act-cus")

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunSubmoduleExample(t *testing.T) {
	options := setupOptions(t, submoduleExampleTerraformDir, "iam-act-submodule")

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}
