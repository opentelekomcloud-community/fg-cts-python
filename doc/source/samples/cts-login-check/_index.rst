Sample to identify login and logout operations from invalid IP addresses
===============================================================================

.. toctree::
    :maxdepth: 1
    :hidden:


This function analyzes received operation records, filters logins or logouts
from unauthorized IP addresses using a whitelist, and sends alarms under a specified SMN topic.

This function can be used to build an account security monitoring service.

Prerequisites
-------------

Before running this example, ensure you have the following:

- :ref:`prerequisites`

FunctionGraph function
-----------------------

.. literalinclude:: ../../../../cts-login-check/src/index.py
  :language: python
  :caption: cts-login-check/src/index.py

.. list-table::
   :header-rows: 1

   * - Environment variable
     - Sample value
     - Description
   * - SMN_TOPIC_URN
     - urn:smn:eu-de:1234567890:my-topic
     - The SMN topic to send alarms to.
   * - SMN_ENDPOINT
     - smn.eu-de.otc.t-systems.com
     - The SMN endpoint to send alarms to.
   * - IP_RANGES_WHITELIST
     - 10.0.0.1/28
     - Comma separated list of IP ranges that are allowed to access the system.

Terraform deployment files
--------------------------

Terraform config files
""""""""""""""""""""""""""""""""""""""""""""""

.. tabs::

    .. tab:: variables.tf

      .. literalinclude:: ../../../../cts-login-check/terraform/variables.tf
        :language: hcl
        :caption: cts-login-check/terraform/variables.tf

    .. tab:: variables.tfvars

      .. literalinclude:: ../../../../cts-login-check/terraform/variables.tfvars
        :language: hcl
        :caption: cts-login-check/terraform/variables.tfvars

    .. tab:: variables.auto.tfvars

        Create and adapt this file with your own values:

       .. code-block:: hcl
          :caption: cts-login-check/terraform/variables.auto.tfvars

          SMN_EMAIL_ADDRESS = ["user1@company.com","user2@company.com"]
          IP_RANGES_WHITELIST = ["10.0.0.1/28"]

          TEST_USER_NAME = "user"
          TEST_USER_ID = "userid"

          TEST_ALLOWED_SOURCE_IP = "10.0.0.1"
          TEST_DENIED_SOURCE_IP = "127.0.0.1"


FunctionGraph deployment files
""""""""""""""""""""""""""""""""""""""""""""""
.. tabs::

    .. tab:: Function

      .. literalinclude:: ../../../../cts-login-check/terraform/function.tf
        :language: hcl
        :caption: cts-login-check/terraform/function.tf
   
    .. tab:: Function Agency

      .. literalinclude:: ../../../../cts-login-check/terraform/function-agency.tf
        :language: hcl
        :caption: cts-login-check/terraform/function-agency.tf

    .. tab:: Function CTS trigger

      .. literalinclude:: ../../../../cts-login-check/terraform/function-trigger-cts.tf
        :language: hcl
        :caption: cts-login-check/terraform/function-trigger-cts.tf

    .. tab:: Function LogGroup

      .. literalinclude:: ../../../../cts-login-check/terraform/function-logging.tf
        :language: hcl
        :caption: cts-login-check/terraform/function-logging.tf

    .. tab:: Function test events

      .. literalinclude:: ../../../../cts-login-check/terraform/function-testevent-cts.tf
        :language: hcl
        :caption: cts-login-check/terraform/function-testevent-cts.tf

SMN deployment files
""""""""""""""""""""""""""""""""""""""""""""""
.. tabs::

    .. tab:: SMN

      .. literalinclude:: ../../../../cts-login-check/terraform/smn.tf
        :language: hcl
        :caption: cts-login-check/terraform/smn.tf

Variables
""""""""""""""""""""""""""""""""""""""""""""""

Sample variables file:

.. literalinclude:: ../../../../cts-login-check/terraform/variables.tfvars
  :language: hcl
  :caption: cts-login-check/terraform/variables.tfvars


You might want to adjust the variables to your need.

Makefile
""""""""""""""""""""""""""""""""""""""""""""""

Sample Makefile:

.. literalinclude:: ../../../../cts-login-check/Makefile
  :language: make
  :caption: cts-login-check/Makefile

You might want to adjust the following variables to your need:

.. code-block:: make

    # Terraform backend configuration
    BACKEND_CONFIG_BUCKET := "doc-samples-tf-backend"
    BACKEND_CONFIG_KEY := "terraform_state/python/custom-rule-cts-login-check.tf"
    BACKEND_CONFIG_REGION := "eu-de"
    BACKEND_CONFIG_ENDPOINTS := "endpoints={s3=\"https://obs.eu-de.otc.t-systems.com\"}"


Deploy
--------------

To deploy using Terraform run:

.. code-block:: bash

    make tf_apply

To destroy the deployed resources using Terraform run:

.. code-block:: bash

    make tf_destroy
