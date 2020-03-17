## Azure Governance

**Azure Governance** is a set of platform native capabilities that enable Cloud architects and Cloud Engineers to quickly and easily set the right guardrails for security, compliance and everyday cost management, across all Azure subscriptions. And this is especially important during the DevOps process as apps are being built, deployed and managed in production.

Through this lab, you will go through the following Capabilities or components:

* Azure Management Groups
* Azure Policy
* Azure Blueprints
* Azure Resource Graph

## Azure Management Group

An **Azure Management Group** is a logical collection of Subscriptions and other Management Groups, to simplify administration and governance. You can build a hierarchical structure of Management Groups and Subscriptions and apply governance conditions, like Policies and RBAC access, at the top level. All Subscriptions and nested Management Groups will then inherit the conditions applied to the Parent Management Group.

In this Lab you will:

* Create a new management group
* Add a Role assignment (RBAC) to a management group
* Create nested management groups
* Move a subscription under a different management group
* Move a management group in the hierarchy

## Azure Policy

**Azure Policy** lets you create, assign, and manage policies. These policies can enforce different rules and effects over the resources, so those resources stay compliant with corporate standards and service level agreements. Azure Policy meets this need by evaluating resources for non-compliance with assigned policies. Once policies are implemented, new and existing resources are evaluated for compliance.

In this Lab you will:

* Create a custom Policy
* Create custom and built-in policies assignment
* Include policies in Blueprints
* Review non-compliance
* Remediate non-compliant resources
* Review change history of resources

## Azure Blueprints

**Azure Blueprints** help you deploy and update cloud environments in a repeatable manner using composable artifacts such as Azure Resource Manager templates to provision resources, role-based access controls and policies.

Learning how to create and assign blueprints enables the definition of common patterns to develop reusable and rapidly deployable configurations based on Resource Manager templates, policy, security, and more. 

In this Lab you will:

*   Create a new blueprint and add various supported artifacts
*   Make changes to an existing blueprint still in Draft
*   Mark a blueprint as Published and ready to assign
*   Assign a blueprint to an existing subscription
*   Check the status and progress of an assigned blueprint

## Azure Resource Graph Explorer

**Azure Resource Graph** provides resource exploration with the ability to query at scale across all subscriptions and management groups.

In this Lab you will run several Azure CLI queries to explore Azure resources in many different ways.