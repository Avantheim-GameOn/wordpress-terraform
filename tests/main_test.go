package test

import (
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
)

func TestAlbResponse(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../infra",
	}

	// ⚠️ Comentado para NÃO destruir a infraestrutura real após o teste
	// defer terraform.Destroy(t, terraformOptions)

	// Aplica a infraestrutura (vai fazer o plan/apply novamente)
	terraform.InitAndApply(t, terraformOptions)

	// Lê o output "alb_dns_name" definido no Terraform
	albDNS := terraform.Output(t, terraformOptions, "alb_dns_name")
	url := fmt.Sprintf("http://%s", strings.TrimSpace(albDNS))

	// Valida se o ALB responde com HTTP 200 OK
	expectedStatus := 200
	maxRetries := 10
	timeBetweenRetries := 10 * time.Second

	http_helper.HttpGetWithRetry(t, url, nil, expectedStatus, "", maxRetries, timeBetweenRetries)
}