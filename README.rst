IATI Standard SSOT
==================

.. image:: https://travis-ci.org/IATI/IATI-Standard-SSOT.svg?branch=version-2.03
    :target: https://travis-ci.org/IATI/IATI-Standard-SSOT
.. image:: https://requires.io/github/IATI/IATI-Standard-SSOT/requirements.svg?branch=version-2.03
    :target: https://requires.io/github/IATI/IATI-Standard-SSOT/requirements/?branch=version-2.03
    :alt: Requirements Status
.. image:: https://img.shields.io/badge/license-MIT-blue.svg
    :target: https://github.com/IATI/IATI-Standard-SSOT/blob/version-2.03/LICENSE

Introduction
------------

This is the main github repository for the IATI Standard Single Source of Truth's Reference Site (SSOT). For more detailed information about the SSOT, please see http://iatistandard.org/developer/ssot/

Building the Reference
==========================

Requirements:

* Git
* Unix based setup (e.g. Linux, Mac OS X) with bash etc.
* Python 3.x
* gcc
* Development files for libxml and libxslt e.g. libxml2-dev, libxslt-dev

Fetch the source code:::

    git clone https://github.com/IATI/IATI-Standard-SSOT.git

Set up a dev environment:

.. code-block:: bash

    # Cleans a previous installation
    make clean_all

    # Creates a virtual environment (recommended) &
    # installs the requirements
    make setup

    # Clones the SSOT components
    make clone_components

    # This can be run as a one line command as well
    make dev_install

Build the documentation:::

    make build_rst

Build the html version:::

    make build_html

The built documentation is now in ``docs/<language>/_build/dirhtml``


Generating a local version with the IATI theme
==============================================

A local version of the website (with the full IATI theme) can be generated after cloning the theme files and setting up the required symlinks for Sphinx to follow when generating the HTML files.

.. code-block:: bash

    # Build the local dev version

    make build_dev

    # To switch version of the standard

    make switch_version <version_number>

    # Run your locally built copy

    make run

Deploying the Reference Site
==============================================

*TBD*