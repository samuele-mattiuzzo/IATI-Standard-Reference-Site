The breakdown of what's happening behind the scenes is as follows

.. code-block:: bash

   # Clone the repository containing the IATI theme at the same level where you cloned IATI-Standard-SSOT
   git clone https://github.com/IATI/IATI-Websites.git IATI-Websites

   # Set-up symlinks to the template file/folders
   # for the symlinks to work, you'll have to be inside the IATI-Extra-Documentation folder cloned inside IATI-Standard-SSOT
   cd IATI-Extra-Documentation/en
   ln -s ../../../IATI-Websites/iatistandard/_templates/ ./
   ln -s ../../../IATI-Websites/iatistandard/_static/ ./
   ln -s ../../../IATI-Websites/iatistandard/_templates/layout_dev.html ./_templates/layout.html

   # Generate a version of the documentation
   cd ../../
   ./combined_gen.sh

   # The documentation HTML files are stored in the `docs-copy/en/_build/dirhtml` folder
   # You can navigate around your generated version of the site using a Python HTTP webserver
   cd docs-copy/en/_build/dirhtml
   python3 -m http.server
   # View the site in a browser at http://0.0.0.0:8000/


Make any changes in ``IATI-Extra-Documentation``, as the ``docs`` directory is generated from
this and other sources each time ``./gen.sh`` is run.


There is additonal guidance in the following git repositories:

* https://github.com/IATI/IATI-Guidance
* https://github.com/IATI/IATI-Developer-Documentation/

These are not versioned with the standard, so are not included in the SSOT repository (`IATI-Standard-SSOT <https://github.com/IATI/IATI-Standard-SSOT>`__) or its submodules.

To generate a copy of the website with these extra repositories included, run:

.. code-block:: bash

   # If you have not done already create the docs directory as a git repository
   # (more info below)
   mkdir docs
   cd docs
   git init
   cd ..
   # Actually run the generate script
   ./combined_gen.sh

This generates the website in the ``docs`` directory, but then copies it to ``docs-copy`` at the end, so that a webserver can be pointed to ``docs-copy/en/_build/dirhtml`` and not be interrupted when the site is being rebuilt.

The ``docs`` directory should be a git repository in order to support adding the "Last updated" line to the bottom of the page. We build the live and dev websites in different directories so that the last updated date corresponds to when the site was actually changed, not when the relevant commit was added to the source git respository.


