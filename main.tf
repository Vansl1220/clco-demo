terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_cli = true
}

resource "azurerm_resource_group" "rg" {
  name     = "a4-rg"
  location = "italynorth"
}

resource "azurerm_service_plan" "plan" {
  name                = "a4-plan"
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "a4-webapp-demo1234"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "italynorth"
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      python_version = "3.11"
    }
  }
}
