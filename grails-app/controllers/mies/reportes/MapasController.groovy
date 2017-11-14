package mies.reportes

import mies.*

class MapasController {

    def index = {
        def map = ""
        (Provincia.list()).each { prov ->
            def url = g.createLink(controller: 'mapas', action: 'provincia', params: ['prov': prov.nombre.toLowerCase().replaceAll(" ", ""), 'nombre': prov.nombreMostrar])
            def title = "<strong>" + prov.nombreMostrar + "</strong>"

            def coords = prov.coords
            if (coords) {

                def proys = []
                def metas = []

                (Canton.findAllByProvincia(prov)).each { canton ->
                    (Parroquia.findAllByCanton(canton)).each { parr ->
                        (Meta.findAllByParroquia(parr)).each { meta ->
                            if (!proys.contains(meta?.marcoLogico?.proyecto)) {
                                proys.add(meta?.marcoLogico?.proyecto)
                            }
                            metas.add(meta)
                        }
                    }
                }
                def text = "<strong>Proyectos en ejecución:</strong> " + proys.size() + "<br/>"
                text += "<strong>Metas:</strong> " + metas.size()

                map += '<area class="area" shape="poly" href="' + url + '" data-title="' + title + '" data-text="' + text + '" coords="' + coords + '">'
            }
        }
        [map: map]
    }

    def provincia = {
        def proyectos = []
        def prov = Provincia.findByNombreIlike(params.nombre)
        def image = g.resource(dir: 'images/mapas/provincias', file: prov.imagen)
        def metas = []
        if (prov) {
            (Canton.findAllByProvincia(prov)).each { canton ->
                Parroquia.findAllByCanton(canton).each { p ->
                    def meta = Meta.findAllByParroquia(p)
                    if (meta.size() > 0) {
                        def pin = "pin0.png"
                        meta.each { e ->
                            def proy = e.marcoLogico.proyecto
                            if (!proyectos.proy.contains(proy)) {
                                pin = "pin" + (proyectos.size()) % 16 + ".png"
                                def pr = [:]
                                pr.proy = proy
                                pr.pin = pin
                                proyectos.add(pr)
                            }
                            def m = [:]
                            def avance = Avance.findAllByMeta(e, [sort: 'valor', order: 'desc', max: 1])
                            def ttip = "", ttitle
                            ttitle = e.indicador + " " + e.tipoMeta.descripcion
                            ttip += "<strong>Proyecto: </strong>" + proy.nombre + "<br/><br/>"
                            if (avance) {
                                avance = avance[0]
                                ttip += "<strong>Avance:</strong> " + avance.descripcion + "<br/>"
                                ttip += "<strong>Valor:</strong> " + avance.valor + "<br/><br/>"
                            }
                            ttip += "<strong>Meta:</strong> " + e.indicador + " " + e.tipoMeta.descripcion + "<br/>"

                            def marco = e.marcoLogico
                            while (marco) {
                                ttip += "<strong>" + marco.tipoElemento.descripcion + ":</strong> " + marco + "</br>"
                                marco = marco.marcoLogico
                            }

                            ttip += "<strong>Unidad:</strong> " + e.unidad + "<br/>"
                            if (avance && e.indicador > 0) {
                                ttip += "<strong>Porcentaje:</strong> " + g.formatNumber(number: ((avance.valor * 100) / meta.indicador), format: "###,##0", minFractionDigits: 2, maxFractionDigits: 2) + "%"
                            }
                            m.meta = e
                            m.ttitle = ttitle
                            m.ttip = ttip
                            m.pin = pin
                            metas.add(m)
                        }
                    } //if meta.size > 0
                } // parroquias
            } //cantones
        } //if prov
        [image: image, prov: params.nombre, metas: metas, proyectos: proyectos]
    }

    def datosMeta = {
        println "datos meta " + params
        def meta = Meta.get(params.id)
        [meta: meta]
    }
}
