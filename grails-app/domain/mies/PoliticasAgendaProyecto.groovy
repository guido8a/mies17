package mies

class PoliticasAgendaProyecto implements Serializable {
    PoliticaAgendaSocial politicaAgendaSocial
    Proyecto proyecto
    static auditable = [ignore: []]
    static mapping = {
        table 'papy'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'papy__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'papy__id'
            politicaAgendaSocial column: 'plas__id'
            proyecto column: 'proy__id'
        }
    }
    static constraints = {
        politicaAgendaSocial(blank: true, nullable: true, attributes: [mensaje: 'Política'])
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
    }
}
