package mies

import mies.ProgramaPresupuestario

class ActividadPresupuesto implements Serializable {
    ProgramaPresupuestario programaPresupuestario
    String codigo
    String descripcion
    static auditable=[ignore:[]]
    static mapping = {
        table 'acps'
        cache usage:'read-write', include:'non-lazy'
        id column:'acps__id'
        id generator:'identity'
        version false
        columns {
            id column:'acps__id'
            programaPresupuestario column: 'pgps__id'
            codigo column: 'acpscdgo'
            descripcion column: 'acpsdscr'
        }
    }
    static constraints = {
        codigo(nullable: false, blank: false)
        descripcion(nullable: false, blank: false)
    }
}
