# NullServe Domain Module

The domain module provisions DNS resources as well as HTTPS certificates for NullServe apps.
If you plan to utilize a mix of cloud providers, you should read the caveats and integration details of the provider you're provider module you're planning to use in its respective folder nested in this directory.
Use of some domain providers will restrict CDN providers, so this should be considered carefully, since this module is the most difficult to change without downtime.