from saxonche import PySaxonProcessor, PySaxonApiError

with PySaxonProcessor() as saxon_proc:
    print(saxon_proc.version)

    xslt30_processor = saxon_proc.new_xslt30_processor()

    xslt30_executable = xslt30_processor.compile_stylesheet(stylesheet_file='iterate-try-catch-test1.xsl');

    try:
        xslt30_executable.call_template_returning_file(output_file='saxonc12-result1.xml')
    except PySaxonApiError as e:
        print(e)