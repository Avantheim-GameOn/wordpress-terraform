# 🚀 WordPress AWS Infrastructure with Terraform

Este projeto configura uma stack WordPress altamente disponível na AWS, usando infraestrutura como código com Terraform, práticas CI/CD, observabilidade e estratégia de blue-green deployment.

---

## 📁 Estrutura do Projeto

```
.
├── infra/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── modules/
│   │   ├── vpc/
│   │   ├── ec2/ (blue & green)
│   │   ├── rds/
│   │   ├── alb/
│   │   ├── monitoring/
│   │   └── security_groups/
└── test/
    └── terratest
```

---

## 🧱 Tecnologias Utilizadas

- **Terraform** (infraestrutura como código)
- **AWS** (EC2, RDS, ALB, VPC, CloudWatch)
- **GitHub Actions** (CI/CD)
- **Bash** (instalação WordPress)
- **GoLang** (Terratest)

---

## 🚀 Como Executar

```bash
# Clonar o projeto
git clone https://github.com/GoncaloSecurityOps/wordpress-terraform.git
cd wordpress-terraform/infra

# Inicializar Terraform
terraform init

# Validar e aplicar a infraestrutura
terraform validate
terraform apply
```

> 💡 É necessário definir as GitHub Secrets:  
> `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`  
> (em GitHub > Settings > Secrets)

---

## 📚 Funcionalidades

- ✅ Infraestrutura modular com Terraform
- ✅ CI/CD automático via GitHub Actions
- ✅ WordPress em EC2 com RDS (MySQL)
- ✅ Balanceamento de carga com ALB (blue/green)
- ✅ CloudWatch com alarmes, métricas e dashboards
- ✅ Testes com Terratest

---

## 🔍 Observações

- Otimizado para **AWS Free Tier** (com desligamento de recursos manuais)
- O estado Terraform local pode ser adaptado para backend remoto (S3 + DynamoDB)
- O ALB foi temporariamente desativado para evitar custos extras
- O projeto está estruturado para ser facilmente escalável e reutilizável

---

## 🔗 Autor

**Gonçalo Monteiro**  
[GitHub: @GoncaloSecurityOps](https://github.com/GoncaloSecurityOps)
