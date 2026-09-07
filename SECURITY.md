# Security Policy

## Supported Versions

Security fixes are applied to the actively maintained version of this repository.

| Version               | Supported      |
| --------------------- | -------------- |
| Latest                | ✅ Yes          |
| Older versions        | ⚠️ Best effort |
| Unmaintained versions | ❌ No           |

---

## Reporting a Security Vulnerability

If you discover a security vulnerability in this repository, **do not create a public GitHub Issue or Pull Request**.
Instead, report it privately to the repository maintainers through the organization's approved security reporting process.
When reporting a vulnerability, include:

* Description of the vulnerability
* Affected script or file
* Steps to reproduce the issue
* Potential security impact
* Suggested mitigation, if available
* Relevant logs or screenshots, after removing sensitive information

Please **do not include** passwords, API keys, access tokens, private keys, certificates, or other credentials in the report.

---

## Sensitive Information

The following information must never be committed to this repository:

Passwords
API Connect access tokens
API keys
Client IDs and client secrets
Private keys
TLS certificates containing private key material
Session tokens
Production credentials
Service account credentials
Confidential API definitions
Internal security configuration
```

Use environment variables, approved secret-management solutions, or the organization's credential-management mechanism instead.


## API Connect Credentials
The scripts use the IBM API Connect `apic` CLI.
Authentication should be performed using the organization's approved authentication mechanism.
Do not modify the scripts to contain credentials such as:

USERNAME="myuser"
PASSWORD="mypassword"
TOKEN="my-secret-token"

Instead, authenticate through the API Connect Toolkit/CLI and keep credentials outside source control.

## Production Environment

Exercise additional caution when executing these scripts against production API Connect environments.

Before execution:
1. Confirm the target API Connect server.
2. Confirm the Organization.
3. Confirm the Catalog.
4. Confirm the authenticated user.
5. Verify that the user has only the permissions required.
6. Confirm the output location.
7. Ensure downloaded API definitions are stored securely.
Note: Run the code in nnon-prod environments and learn from it before executing it in prod.

## Responsible Disclosure

If you discover a potential security vulnerability in this repository, please report it privately to the repository owner or the appropriate security team rather than creating a public GitHub issue.

This repository is provided for **informational and automation purposes only**. The content owner and repository maintainers are **not responsible or liable for any direct or indirect loss, damage, security incident, service disruption, data exposure, or other consequences resulting from the use, misuse, modification, or execution of the scripts or information provided in this repository**.

Users are solely responsible for:

* Reviewing the scripts before execution.
* Validating the commands and configuration for their environment.
* Ensuring appropriate authorization and access controls.
* Protecting credentials and sensitive information.
* Complying with their organization's security, governance, and change-management policies.
* Assessing the impact of running the scripts against development, test, DR, or production environments.

By using the content in this repository, you acknowledge that you do so **at your own risk and responsibility**.

The repository owner and content contributors make no guarantees regarding the accuracy, completeness, availability, reliability, or suitability of the provided scripts for any particular environment or purpose.
