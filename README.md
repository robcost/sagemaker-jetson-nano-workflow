# Sagemaker Jetson Nano ML Workflow

This repo provides a workflow for creating and managing Machine Learning models in AWS SageMaker, and running them on a Jetson Nano SBC device. The goal of this repo is to show how to create multiple object detection ML models using MXNet, TensorFlow, and PyTorch, and deploy the models to a Jetson Nano.

## Requirements

Below is the gear I used, however you may not want/need all these items, and some may be different based on your geographical location.

- An AWS Account
- [Jetson Nano Developer Kit](https://developer.nvidia.com/embedded/jetson-nano-developer-kit) *Required*
- [Noctua NF-A4x20 5V PWM 40mm fan](https://www.amazon.com.au/gp/product/B071FNHVXN/)
- [AC 100-240V to DC 5V 4A Switching Power Supply](https://www.amazon.com.au/gp/product/B07RSRK92W/) *may vary based on location*
- [Samsung FIT Plus Flash Drive 128 GB](https://www.amazon.com.au/gp/product/B07D7PDLXC/)
- [Waveshare AC8265 Wireless NIC Module for Jetson Nano Supports 2.4GHz / 5GHz Dual Band WiFi and Bluetooth 4.2](https://www.amazon.com.au/gp/product/B07SGDRG34/ref=ppx_yo_dt_b_asin_title_o08_s00?ie=UTF8&psc=1)
- [Waveshare Metal Case Type B for Jetson Nano Developer Kit with Camera Holder, Reset and Power Buttons](https://www.amazon.com.au/gp/product/B07VTNSS4S/)

---
## Workflow Overview

Once you have your Jetson Nano and an AWS account ready to go we'll work our way through the following:

- Setting up the Jetson Nano, including:
    - Booting from the USB drive instead of the MicroSD card
    - Setting up swap space to give the Jetson more working memory to work with
    - Cloning this repo to run setup scripts from

- Setting up Amazon SageMaker to:
    - Perform annotation of your images using SageMaker Ground Truth
    - Cloning this repo to run Notebooks
    - Perform image annotation cleanup tasks
    - Train custom models in MXNet, TensorFlow, and PyTorch

- Setup AWS IoT Greengrass to deploy the custom ML models for inference on the Jetson Nano


---

## Change Log

**1.0.0:**
* Initial release.

---

## License

This library is licensed under the Apache 2.0 License.