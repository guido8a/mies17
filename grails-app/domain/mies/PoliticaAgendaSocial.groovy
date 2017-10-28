package mies

class PoliticaAgendaSocial implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'plas'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'plas__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'plas__id'
            descripcion column: 'plasdscr'
        }
    }
    static constraints = {
        descripcion(blank: false, nullable: false, attributes: [mensaje: 'Descripción'])
    }
}
