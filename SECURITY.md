# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability, please report it by emailing:

**security@bemind.tech**

Please include:

1. Description of the vulnerability
2. Steps to reproduce
3. Potential impact
4. Suggested fix (if any)

### What to Expect

- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 5 business days
- **Resolution Timeline**: Varies based on severity

### Disclosure Policy

- We follow responsible disclosure practices
- We will credit reporters (unless anonymity is requested)
- Public disclosure will occur after the fix is released

## Security Best Practices

### For Contributors

1. **Never commit secrets** - Use `.env` files (not committed)
2. **Use strong types** - Validate all inputs
3. **Follow least privilege** - Minimal permissions
4. **Keep dependencies updated** - Regular security audits

### Protected Files

The following patterns are blocked from commits:

- `*.env` (except `.env.example`)
- `*.key`, `*.pem`, `*.p12`, `*.pfx`
- `*credentials*.json`
- `*secrets*.json`

### Dependency Security

We use:

- `bandit` for Python security scanning
- `pip-audit` for dependency vulnerability checking
- Dependabot for automated security updates

Run security checks:

```bash
make security
```

## Security Features

### Built-in Protections

1. **Input Validation** - Pydantic models for all inputs
2. **Error Handling** - Secure error messages (no stack traces in production)
3. **Configuration** - Environment-based secrets management

### Recommended Additions

For production deployments, consider:

1. Rate limiting
2. CORS configuration
3. HTTPS enforcement
4. Security headers
5. Authentication/Authorization
6. Audit logging
