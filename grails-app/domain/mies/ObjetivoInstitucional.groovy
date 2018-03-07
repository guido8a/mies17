package mies

class ObjetivoInstitucional implements Serializable {

    String codigo
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'obei'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'obei__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'obei__id'
            codigo column: 'obeicdgo'
            descripcion column: 'obeidscr'
        }
    }

    static constraints = {
        codigo(nullable: false, blank: false)
        descripcion(nullable: false, blank: false)
    }
}
