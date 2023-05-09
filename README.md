This repository is used to record the process and scripts I used in the performance test of Intel-SGX, AMD-SEV and Hygon-CSV.

#### TEE introduction

A TEE (Trusted Execution Environment) is an isolated processing environment in which applications can be securely executed irrespective of the rest of the system. TEEs are CPU-encrypted isolated private enclaves inside the memory, used for protecting data in use at the hardware level. While the sensitive data is inside an enclave, unauthorized entities cannot remove it, modify it, or add more data to it. TEEs also prevent code in the enclave from being replaced or modified by external entities. TEEs can provide benefits such as enhanced security, privacy, and performance for various applications, but they also face challenges such as scalability, interoperability, and usability.

There are many kinds of commercial TEE on the market, and only three of them are selected for testing in this project.

###### Intel-SGX

Intel SGX (Software Guard Extensions) is a technology that offers hardware-based memory encryption that isolates specific application code and data in memory. Intel SGX allows user-level code to allocate private regions of memory, called enclaves, which are designed to be protected from processes running at higher privilege levels1. Intel-SGX helps protect data in use from many known active threats by reducing the system's attack surface and adding another layer of defense. Intel SGX also provides enhanced security and verification features to enable a wide range of applications such as cloud computing, blockchain, AI, and IoT.

###### AMD-SEV

AMD SEV (Secure Encrypted Virtualization) is a feature found on AMD processors that supports running encrypted virtual machines (VMs) under the control of a hypervisor. SEV uses one key per VM to isolate guests and the hypervisor from one another, and the keys are managed by the AMD Secure Processor. SEV also has an extension called SEV-ES, which encrypts all CPU register contents when a VM stops running, to prevent information leakage or malicious modifications. SEV requires enablement in the guest operating  system and hypervisor.

###### Hygon-CSV

Hygon CSV (China Security Virtualization) is a technology that provides a trusted execution environment (TEE) for applications running on Hygon CPUs, which are domestic x86 architecture chips1. Hygon CSV uses encryption to isolate and protect application resources from illegal tampering. Hygon CSV also supports confidential containers, which are a way of deploying applications with enhanced security and privacy2. Hygon CSV is the first complete solution for confidential containers in OpenAnolis, an open source operating system community.

#### Test Benchmark

The tests covered CPU overhead, I/O throughput, blockchain consensus protocols, database systems, and some classic AI algorithms.