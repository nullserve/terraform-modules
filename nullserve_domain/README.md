# NullServe Domain Module

The **NullServe domain** module provisions DNS resources as well as TLS certificates for NullServe itself.
This module is **not** used as the root domain for apps.
You should use the `app_domain` module for that.

**⚠️ Warning:** If you plan to utilize a mix of cloud providers, you should read the caveats and integration details of the provider module you're planning to use in its respective folder of this directory.
Use of some domain providers will restrict your options for CDN providers, so this should be considered carefully, since this module is the most difficult to change without downtime.