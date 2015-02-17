README


Change:

```json
  "variables": {
    ...
    "app_name" : "suripu-app",
    "app_version" : "0.2.65"
  }
```

to map the app version you'd like to build an AMI for.

Then run

`packer build -var 'aws_access_key=AKIAII76K2Z5IMMJYEIA' -var 'aws_secret_key=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' suripu-app.json`