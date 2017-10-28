package mies

import mies.Formatos
import org.springframework.web.servlet.support.RequestContextUtils

import java.text.DecimalFormatSymbols

class CustomTagLib {

    static namespace = 'tdn'

    /**
     * Dump out attributes in HTML compliant fashion.
     */
    void outputAttributes(attrs) {
        attrs.remove('tagName') // Just in case one is left
        def writer = getOut()
        attrs.each { k, v ->
            writer << "$k=\"${v.encodeAsHTML()}\" "
        }
    }

    def renderNoSelectionOptionImpl(out, noSelectionKey, noSelectionValue, value) {
        // If a label for the '--Please choose--' first item is supplied, write it out
        out << "<option value=\"${(noSelectionKey == null ? '' : noSelectionKey)}\"${noSelectionKey == value ? ' selected="selected"' : ''}>${noSelectionValue.encodeAsHTML()}</option>"
    }

    def mostrarCampoModificacion = {attrs ->
        def mod = ModificacionV2.get(attrs.id)
        def campo = attrs.campo
       // println "mod "+mod+" campo "+campo+" tipo "+mod.tipo
        def valor
        if (campo=="oldValue")
            valor=mod.oldValue
        else
            valor=mod.newValue

        switch (mod.tipo){
            case "number":
                out << g.formatNumber(number:valor, format: '###,##0', maxFractionDigits: 2, minFractionDigits: 2)
                break;
            case "string":
                out << valor
                break;
            case "date":
                try{
                    out << valor.format("dd/MM/yyyy")
                }catch(e) {
                    out << valor
                    println "error date  "+e
                }
                break;
            default:
                try{
                   // println "mod tipo "+mod.tipo
                    def cl = grailsApplication.getArtefact("Domain",mod.tipo)?.getClazz()?.get(valor)
                    out << cl.toString()
                }catch(e) {
                    out << valor
                    println "error tipo dominio  "+e
                }
                break;
        }

    }

    def selectMonth = { attrs ->
        def from = [1: "Enero", 2: "Febrero", 3: "Marzo", 4: "Abril", 5: "Mayo", 6: "Junio", 7: "Julio", 8: "Agosto", 9: "Septiembre", 10: "Octubre", 11: "Noviembre", 12: "Diciembre"]
        def optionKey = "key"
        def optionValue = "value"

        attrs.from = from
        attrs.optionKey = optionKey
        attrs.optionValue = optionValue

        out << g.select(attrs)
    }

    /**
     * Renders a sortable column to support sorting in list views.<br/>
     *
     * Attribute title or titleKey is required. When both attributes are specified then titleKey takes precedence,
     * resulting in the title caption to be resolved against the message source. In case when the message could
     * not be resolved, the title will be used as title caption.<br/>
     *
     * Examples:<br/>
     *
     * &lt;g:sortableColumn property="title" title="Title" /&gt;<br/>
     * &lt;g:sortableColumn property="title" title="Title" style="width: 200px" /&gt;<br/>
     * &lt;g:sortableColumn property="title" titleKey="book.title" /&gt;<br/>
     * &lt;g:sortableColumn property="releaseDate" defaultOrder="desc" title="Release Date" /&gt;<br/>
     * &lt;g:sortableColumn property="releaseDate" defaultOrder="desc" title="Release Date" titleKey="book.releaseDate" /&gt;<br/>
     *
     * @attr property - name of the property relating to the field
     * @attr defaultOrder default order for the property; choose between asc (default if not provided) and desc
     * @attr title title caption for the column
     * @attr titleKey title key to use for the column, resolved against the message source
     * @attr params a map containing request parameters
     * @attr action the name of the action to use in the link, if not specified the list action will be linked
     * @attr params A map containing URL query parameters
     * @attr class CSS class name
     */
    def sortableColumn = { attrs ->
        def writer = out
        if (!attrs.property) {
            throwTagError("Tag [sortableColumn] is missing required attribute [property]")
        }

        if (!attrs.title && !attrs.titleKey) {
            throwTagError("Tag [sortableColumn] is missing required attribute [title] or [titleKey]")
        }

        def property = attrs.remove("property")
        def action = attrs.action ? attrs.remove("action") : (actionName ?: "list")

        def defaultOrder = attrs.remove("defaultOrder")
        if (defaultOrder != "desc") defaultOrder = "asc"

        // current sorting property and order
        def sort = params.sort
        def order = params.order

        // add sorting property and params to link params
        def linkParams = [:]
        if (params.id) linkParams.put("id", params.id)
        if (attrs.params) linkParams.putAll(attrs.remove("params"))
        linkParams.sort = property

        // determine and add sorting order for this column to link params
        attrs.class = (attrs.class ? "${attrs.class} sortable" : "sortable")
        if (property == sort) {
            attrs.class = attrs.class + " sorted ui-state-highlight " + order
            if (order == "asc") {
                linkParams.order = "desc"
            }
            else {
                linkParams.order = "asc"
            }
        }
        else {
            linkParams.order = defaultOrder
        }

        // determine column title
        def title = attrs.remove("title")
        def titleKey = attrs.remove("titleKey")
        if (titleKey) {
            if (!title) title = titleKey
            def messageSource = grailsAttributes.messageSource
            def locale = RequestContextUtils.getLocale(request)
            title = messageSource.getMessage(titleKey, null, title, locale)
        }

        writer << "<th "
        // process remaining attributes
        attrs.each { k, v ->
            writer << "${k}=\"${v.encodeAsHTML()}\" "
        }
        writer << ">${link(action: action, params: linkParams) { title }}</th>"
    } //sortable column

    /**
     * Creates next/previous links to support pagination for the current controller.<br/>
     *
     * &lt;g:paginate total="${Account.count()}" /&gt;<br/>
     *
     * @attr total REQUIRED The total number of results to paginate
     * @attr action the name of the action to use in the link, if not specified the default action will be linked
     * @attr controller the name of the controller to use in the link, if not specified the current controller will be linked
     * @attr id The id to use in the link
     * @attr params A map containing request parameters
     * @attr prev The text to display for the previous link (defaults to "Previous" as defined by default.paginate.prev property in I18n messages.properties)
     * @attr next The text to display for the next link (defaults to "Next" as defined by default.paginate.next property in I18n messages.properties)
     * @attr max The number of records displayed per page (defaults to 10). Used ONLY if params.max is empty
     * @attr maxsteps The number of steps displayed for pagination (defaults to 10). Used ONLY if params.maxsteps is empty
     * @attr offset Used only if params.offset is empty
     * @attr fragment The link fragment (often called anchor tag) to use
     */
    def paginate = { attrs ->
        def writer = out
        if (attrs.total == null) {
            throwTagError("Tag [paginate] is missing required attribute [total]")
        }

        def messageSource = grailsAttributes.messageSource
        def locale = RequestContextUtils.getLocale(request)

        def total = attrs.int('total') ?: 0
        def action = (attrs.action ? attrs.action : (params.action ? params.action : "list"))
        def offset = params.int('offset') ?: 0
        def max = params.int('max')
        def maxsteps = (attrs.int('maxsteps') ?: 10)

        if (!offset) offset = (attrs.int('offset') ?: 0)
        if (!max) max = (attrs.int('max') ?: 10)

        def linkParams = [:]
        if (attrs.params) linkParams.putAll(attrs.params)
        linkParams.offset = offset - max
        linkParams.max = max
        if (params.sort) linkParams.sort = params.sort
        if (params.order) linkParams.order = params.order

        def linkTagAttrs = [action: action]
        if (attrs.controller) {
            linkTagAttrs.controller = attrs.controller
        }
        if (attrs.id != null) {
            linkTagAttrs.id = attrs.id
        }
        if (attrs.fragment != null) {
            linkTagAttrs.fragment = attrs.fragment
        }
        linkTagAttrs.params = linkParams

        // determine paging variables
        def steps = maxsteps > 0
        int currentstep = (offset / max) + 1
        int firststep = 1
        int laststep = Math.round(Math.ceil(total / max))

        // display previous link when not on firststep
        if (currentstep > firststep) {
            linkTagAttrs.class = 'prevLink'
            linkParams.offset = offset - max
            writer << link(linkTagAttrs.clone()) {
                (attrs.prev ?: messageSource.getMessage('paginate.prev', null, messageSource.getMessage('default.paginate.prev', null, 'Previous', locale), locale))
            }
        }

        // display steps when steps are enabled and laststep is not firststep
        if (steps && laststep > firststep) {
            linkTagAttrs.class = 'step'

            // determine begin and endstep paging variables
            int beginstep = currentstep - Math.round(maxsteps / 2) + (maxsteps % 2)
            int endstep = currentstep + Math.round(maxsteps / 2) - 1

            if (beginstep < firststep) {
                beginstep = firststep
                endstep = maxsteps
            }
            if (endstep > laststep) {
                beginstep = laststep - maxsteps + 1
                if (beginstep < firststep) {
                    beginstep = firststep
                }
                endstep = laststep
            }

            // display firststep link when beginstep is not firststep
            if (beginstep > firststep) {
                linkParams.offset = 0
                writer << link(linkTagAttrs.clone()) {firststep.toString()}
                writer << '<span class="step">..</span>'
            }

            // display paginate steps
            (beginstep..endstep).each { i ->
                if (currentstep == i) {
                    writer << "<span class=\"currentStep ui-state-highlight\">${i}</span>"
                }
                else {
                    linkParams.offset = (i - 1) * max
                    writer << link(linkTagAttrs.clone()) {i.toString()}
                }
            }

            // display laststep link when endstep is not laststep
            if (endstep < laststep) {
                writer << '<span class="step">..</span>'
                linkParams.offset = (laststep - 1) * max
                writer << link(linkTagAttrs.clone()) { laststep.toString() }
            }
        }

        // display next link when not on laststep
        if (currentstep < laststep) {
            linkTagAttrs.class = 'nextLink'
            linkParams.offset = offset + max
            writer << link(linkTagAttrs.clone()) {
                (attrs.next ? attrs.next : messageSource.getMessage('paginate.next', null, messageSource.getMessage('default.paginate.next', null, 'Next', locale), locale))
            }
        }
    } //pagination


    /**
     * Devuelve un número con formato.
     * Utiliza la configuración de números de la aplicación
     */
    def formatNumber = { attrs ->
        def number = attrs.get('number')

        if (!number) {
            number = new Double(0)
        }

        def format = attrs.get('format')
        if (!format) {
            format = "0"
        }

        def locale = new Locale(Formatos.getLang(), Formatos.getCountry())
        //def locale = new Locale("es", "EC")
        DecimalFormatSymbols dcfs = locale ? new DecimalFormatSymbols(locale) : new DecimalFormatSymbols()

        char sd = Formatos?.separadorDecimal
        char sm = Formatos?.separadorMiles
        //char sd = "."
        //char sm = ","

        /*if(grailsApplication.config.grails.formatos.separadorDecimal != [:]){
        sd = grailsApplication.config.grails.formatos.separadorDecimal
        }
        if(grailsApplication.config.grails.formatos.separadorMiles != [:]){
        sm = grailsApplication.config.grails.formatos.separadorMiles
        }*/

        if (sd) {
            dcfs.setDecimalSeparator(sd)
        }
        if (sm) {
            dcfs.setGroupingSeparator(sm)
        }

        out << new java.text.DecimalFormat(format, dcfs).format((Double) number)

    }  //formatNumber

}
