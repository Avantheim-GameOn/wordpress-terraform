# WordPress AWS Deployment with Terraform

Este projeto implementa o deploy completo de uma aplicação **WordPress** em **AWS**, utilizando **Terraform** como ferramenta de Infrastructure as Code (IaC) e **GitHub Actions** para CI/CD.

---

## 🚀 Objetivo

Desenvolver uma infraestrutura automatizada e escalável na AWS, com base num desafio técnico que exige:

- Deploy de WordPress na AWS
- Utilização de boas práticas com Terraform
- Pipeline CI/CD automatizado
- Monitorização básica da stack
- Bónus: Blue-Green deployment e testes automatizados

---

## 🧰 Stack utilizada

- **Terraform** (Infraestrutura como Código)
- **AWS** (EC2, RDS, VPC, ALB, CloudWatch, IAM)
- **GitHub Actions** (Deploy automático)
- **Terratest** (Testes de infraestrutura em Golang)

---

## 📦 Estrutura dos módulos

```bash
infra/
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── ec2/
│   ├── rds/
│   ├── vpc/
│   ├── alb/
│   └── monitoring/