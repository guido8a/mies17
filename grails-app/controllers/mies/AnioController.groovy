package mies

class AnioController   extends mies.seguridad.Shield{

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def dbConnectionService
    def kerberosService

    def index = {
        redirect(action: "list", params: params)
    }

    def vistaAprobarAño = {
        def anios = Anio.findAllByEstado(0)
        [anios:anios]
    }

    def detalleAnio = {
        def anio = Anio.get(params.anio)
        def unidades = UnidadEjecutora.list([sort:"nombre"])
        def cn = dbConnectionService.getConnection()
        def datos = [:]
        unidades.each {
            def temp = []
            cn.eachRow("select count(asgn__id) as cont,sum(asgnplan) as suma from asgn where unej__id=${it.id} and anio__id = ${anio.id} and mrlg__id is not null "){d->
                if(d.suma==null)
                    temp.add(0)
                else
                    temp.add(d.suma.toFloat().round(2))
                if(d.cont==null)
                    temp.add(0)
                else
                    temp.add(d.cont)
            }
            cn.eachRow("select count(obra__id) as cont,sum(obracntd*obracsto) as suma from obra,asgn where asgn.asgn__id=obra.asgn__id and   asgn.unej__id=${it.id} and asgn.anio__id = ${anio.id} and asgn.mrlg__id is not null "){d->
                if(d.suma==null)
                    temp.add(0)
                else
                    temp.add(d.suma.toFloat().round(2))
                if(d.cont==null)
                    temp.add(0)
                else
                    temp.add(d.cont)
            }

            cn.eachRow("select count(asgn__id) as cont,sum(asgnplan) as suma from asgn where unej__id=${it.id} and anio__id = ${anio.id} and actv__id is not null "){d->
                if(d.suma==null)
                    temp.add(0)
                else
                    temp.add(d.suma.toFloat().round(2))
                if(d.cont==null)
                    temp.add(0)
                else
                    temp.add(d.cont)
            }
            cn.eachRow("select count(obra__id) as cont,sum(obracntd*obracsto) as suma from obra,asgn where asgn.asgn__id=obra.asgn__id and   asgn.unej__id=${it.id} and asgn.anio__id = ${anio.id} and asgn.actv__id is not null "){d->
                if(d.suma==null)
                    temp.add(0)
                else
                    temp.add(d.suma.toFloat().round(2))
                if(d.cont==null)
                    temp.add(0)
                else
                    temp.add(d.cont)
            }
            temp.add(it.id)
            if((temp[0]+temp[2]+temp[4]+temp[6])>0)
                datos.put(it.nombre+"5"+it.id,temp)
            temp=[]

        }

        cn.close()

        [datos:datos,anio:anio]
    }

    def aprobarAnio = {
        if (request.method == 'POST') {
            println "params " + params
            if (session.usuario.autorizacion == params.ssap.encodeAsMD5()) {
                def anio = Anio.get(params.anio)
                anio.estado=1
                kerberosService.saveObject(anio, Anio, session.perfil, session.usuario, "aprobarAnio", "anio", session)
                render "ok"
            } else {
                render "no"
            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }

    def list = {
        def title = g.message(code:"default.list.label", args:["Anio"], default:"Anio List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 25, 100)

        [anioInstanceList: Anio.list(params), anioInstanceTotal: Anio.count(), title: title, params:params]
    }

    def form = {
        def title
        def anioInstance

        if(params.source == "create") {
            anioInstance = new Anio()
            anioInstance.properties = params
            title = "Crear año fiscal"
        } else if(params.source == "edit") {
            anioInstance = Anio.get(params.id)
            if (!anioInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'anio.label', default: 'Anio'), params.id])}"
                redirect(action: "list")
            }
            title = "Editar año fiscal"
        }

        return [anioInstance: anioInstance, title:title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action:"form", params:params)
    }

    def save = {
        def title
        if(params.id) {
            title = g.message(code:"default.edit.label", args:["Anio"], default:"Edit Anio")
            def anioInstance = Anio.get(params.id)
            if (anioInstance) {
                anioInstance.properties = params
                if (!anioInstance.hasErrors() && anioInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'anio.label', default: 'Anio'), anioInstance.id])}"
                    redirect(action: "show", id: anioInstance.id)
                }
                else {
                    render(view: "form", model: [anioInstance: anioInstance, title:title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'anio.label', default: 'Anio'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code:"default.create.label", args:["Anio"], default:"Create Anio")
            def anioInstance = new Anio(params)
            if (anioInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'anio.label', default: 'Anio'), anioInstance.id])}"
                redirect(action: "show", id: anioInstance.id)
            }
            else {
                render(view: "form", model: [anioInstance: anioInstance, title:title, source: "create"])
            }
        }
    }

    def update = {
        def anioInstance = Anio.get(params.id)
        if (anioInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (anioInstance.version > version) {

                    anioInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'anio.label', default: 'Anio')] as Object[], "Another user has updated this Anio while you were editing")
                    render(view: "edit", model: [anioInstance: anioInstance])
                    return
                }
            }
            anioInstance.properties = params
            if (!anioInstance.hasErrors() && anioInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'anio.label', default: 'Anio'), anioInstance.id])}"
                redirect(action: "show", id: anioInstance.id)
            }
            else {
                render(view: "edit", model: [anioInstance: anioInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'anio.label', default: 'Anio'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def anioInstance = Anio.get(params.id)
        if (!anioInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'anio.label', default: 'Anio'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code:"default.show.label", args:["Anio"], default:"Show Anio")

            [anioInstance: anioInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action:"form", params:params)
    }

    def delete = {
        def anioInstance = Anio.get(params.id)
        if (anioInstance) {
            try {
                anioInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'anio.label', default: 'Anio'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'anio.label', default: 'Anio'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'anio.label', default: 'Anio'), params.id])}"
            redirect(action: "list")
        }
    }
}
