# Overview

This scenario consists of 4 steps, allowing you to experience a flow that enhances the observability of applications that call a generative AI API:

1. Create a sample application that calls a generative AI API (mock) and verify its behavior.
2. Implement OpenTelemetry (automatic instrumentation) in the created sample application and send telemetry to Jaeger running locally.
3. Introduce OpenLLMetry in the created sample application and send telemetry to Jaeger running locally.
4. Send the telemetry from the created sample application to Instana (SaaS).
   - This step cannot be progressed without having an Instana account.
