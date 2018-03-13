package mies

class PoliticasIgualdad implements Serializable{

    String codigo
    String descripcion

    static auditable = [ignore: []]
    static mapping = {
        table 'plig'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'plig__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'plig__id'
            codigo column: 'pligcdgo'
            descripcion column: 'pligdscr'
        }
    }

    static constraints = {
        codigo(nullable: false, blank: false)
        descripcion(nullable: false, blank: false)
    }
}
