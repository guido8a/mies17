package mies

class DatosEsigef {

    ProgramaPresupuestario programa
    Fuente fuente
    Presupuesto presupuesto
    double vigente
    double comprometido
    UnidadEjecutora unidad
    Date fecha
    String errores

    static auditable=[ignore:[]]
    static mapping = {
        table 'dtes'
        cache usage:'read-write', include:'non-lazy'
        id column:'dtes__id'
        id generator:'identity'
        version false
        columns {
            id column:'dtes__id'
            programa column: 'pgps__id'
            fuente column: 'fnte__id'
            presupuesto column: 'prsp__id'
            vigente column: 'dtesvgnt'
            comprometido column: 'dtescomp'
            unidad column: 'unej__id'
            errors columns:'dteserror'
            fecha column: 'dtesfcha'
        }
    }
    static constraints = {
        errores(size:1..255,blank:true,nullable: true)
        fuente(nullable: true,blank:true)
        programa(nullable: true,blank:true)
        presupuesto(nullable: true,blank:true)
    }
    String toString() {
        return ""+this.programa+" "+this.fuente+" "+this.presupuesto+" "+this.vigente+" "+this.comprometido+" "+this.fecha
    }

}
