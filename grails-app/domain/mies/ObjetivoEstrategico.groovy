package mies

class ObjetivoEstrategico implements Serializable {
    Proyecto proyecto
    String institucion
    String objetivo
    String politica
    String meta
    static auditable = [ignore: []]
    static mapping = {
        table 'obet'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'obet__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'obet__id'
            proyecto column: 'proy__id'
            institucion column: 'obetinst'
            objetivo column: 'obetobjt'
            politica column: 'obetpltc'
            meta column: 'obetmeta'
        }
    }
    static constraints = {
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        institucion(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Objetivo estratégico institucional'])
        objetivo(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Objetivo'])
        politica(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Política'])
        meta(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Meta'])
    }
}