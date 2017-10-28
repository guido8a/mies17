package mies

class EjecucionUE implements Serializable {

    Sigef sigef
    Presupuesto presupuesto
    ProgramaPresupuestario programa
    Fuente fuente
    Proyecto proyecto
    UnidadEjecutora unidadEjecutora
    double vigente=0
    double comprometido=0

    static auditable=[ignore:[]]
    static mapping = {
        table 'ejun'
        cache usage:'read-write', include:'non-lazy'
        id column:'ejun__id'
        id generator:'identity'
        version false
        columns {
            sief column:       'sigf__id'
            presupuesto column:'prsp__id'
            programa column:   'pgps__id'
            fuente column:     'fnte__id'
            proyecto column:   'proy__id'
            unidadEjecutora column: 'unej__id'
            vigente  column:   'ejunvgnt'
            comprometido column:'ejuncmps'
        }
    }
    static constraints = {
        vigente(nullable: false,blank: false)
        comprometido(nullable: false,blank: false)
    }
}