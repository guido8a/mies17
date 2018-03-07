package mies

class PlanDesarrollo implements Serializable {

    String codigo
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'plnd'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'plnd__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'plnd__id'
            codigo column: 'plndcdgo'
            descripcion column: 'plnddscr'
        }
    }

    static constraints = {
        codigo(nullable: false, blank: false)
        descripcion(nullable: false, blank: false)
    }
}
