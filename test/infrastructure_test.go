package test

import (
	"fmt"
	"net/http"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestWebAppModule(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../webapp",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	loadBalancerUrl := terraform.Output(t, terraformOptions, "load_balanncer_ip_addr")

	assert.NotNil(t, loadBalancerUrl, "Load Balancer dns is exposed")

	resp, err := http.Get("http://" + loadBalancerUrl)

	fmt.Println("GET1", resp)
	fmt.Println("GET2", err)

	assert.Nil(t, err)
	assert.Equal(t, resp.StatusCode, 200, "Should get status 200 from load balancer dns")
}
