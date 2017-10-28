package mies

class DocumentoController extends mies.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {

        /*
        def title = g.message(code:"documento.list", default:"Documento List")
//        <g:message code="default.list.label" args="[entityName]" />
        
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [documentoInstanceList: Documento.list(params), documentoInstanceTotal: Documento.count(), title: title, params:params]
        */

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if (!params.sort) {
            params.sort = "id"
        }
        if (!params.order) {
            params.order = "asc"
        }
        def offset = params.offset?.toInteger() ?: 0
        def busca = params.busca?.trim()
        def c = Documento.createCriteria()
        def documentoInstanceList = c.list {
            if (params.busca && busca != "") {
                or {
                    ilike("descripcion", "%" + busca + "%")
                    ilike("clave", "%" + busca + "%")
                    ilike("resumen", "%" + busca + "%")
                    ilike("documento", "%" + busca + "%")
                }
            }
            maxResults(params.max)
            firstResult offset
            order(params.sort, params.order)
        }

        c = Documento.createCriteria()
        def lista = c.list {
            if (params.busca && busca != "") {
                or {
                    ilike("descripcion", "%" + busca + "%")
                    ilike("clave", "%" + busca + "%")
                    ilike("resumen", "%" + busca + "%")
                    ilike("documento", "%" + busca + "%")
                }
            }
        }

        def documentoInstanceTotal = lista.size()

        return [documentoInstanceList: documentoInstanceList, documentoInstanceTotal: documentoInstanceTotal, params: params]
    }

    def downloadDoc = {
        def doc = Documento.get(params.id)
        def archivo = doc.documento
        def proyecto = doc.proyecto
        def entidad = proyecto.unidadEjecutora.subSecretaria.entidad.nombre
        def path = servletContext.getRealPath("/") + "archivos/" + entidad

        def pathFile = path + File.separatorChar + archivo
        def src = new File(pathFile)
        if (src.exists()) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=${src.getName()}")

            response.outputStream << src.newInputStream()
        } else {
            redirect(action: "fileNotFound", params: ['archivo': archivo, 'id': proyecto.id])
        }
    }

    def fileNotFound = {
        return [archivo: params.archivo, id: params.id]
    }

    def form = {
        def title
        def documentoInstance

        if (params.source == "create") {
            documentoInstance = new Documento()
            documentoInstance.properties = params
            title = g.message(code: "documento.create", default: "Create Documento")
        } else if (params.source == "edit") {
            documentoInstance = Documento.get(params.id)
            if (!documentoInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "documento.edit", default: "Edit Documento")
        }

        return [documentoInstance: documentoInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "documento.edit", default: "Edit Documento")
            def documentoInstance = Documento.get(params.id)
            if (documentoInstance) {
                documentoInstance.properties = params
                if (!documentoInstance.hasErrors() && documentoInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])}"
                    redirect(action: "show", id: documentoInstance.id)
                }
                else {
                    render(view: "form", model: [documentoInstance: documentoInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "documento.create", default: "Create Documento")
            def documentoInstance = new Documento(params)
            if (documentoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])}"
                redirect(action: "show", id: documentoInstance.id)
            }
            else {
                render(view: "form", model: [documentoInstance: documentoInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def documentoInstance = Documento.get(params.id)
        if (documentoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (documentoInstance.version > version) {

                    documentoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'documento.label', default: 'Documento')] as Object[], "Another user has updated this Documento while you were editing")
                    render(view: "edit", model: [documentoInstance: documentoInstance])
                    return
                }
            }
            documentoInstance.properties = params
            if (!documentoInstance.hasErrors() && documentoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])}"
                redirect(action: "show", id: documentoInstance.id)
            }
            else {
                render(view: "edit", model: [documentoInstance: documentoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def documentoInstance = Documento.get(params.id)
        if (!documentoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "documento.show", default: "Show Documento")

            [documentoInstance: documentoInstance, title: title]
        }
    }

    def ver = {
        println params
        def documentoInstance = Documento.get(params.id)
        if (!documentoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "documento.show", default: "Show Documento")

            [documentoInstance: documentoInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def documentoInstance = Documento.get(params.id)
        if (documentoInstance) {
            try {
                documentoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'documento.label', default: 'Documento'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'documento.label', default: 'Documento'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), params.id])}"
            redirect(action: "list")
        }
    }
}
