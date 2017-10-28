package mies

class Ejecucion implements Serializable {

    Asignacion asignacion
    Sigef sigef
    double vigente=0
    double compromiso=0
    double devengado=0
    double pagado=0
    double saldoPresupuesto=0
    double saldoDisponible=0

    static auditable=[ignore:[]]
    static mapping = {
        table 'ejec'
        cache usage:'read-write', include:'non-lazy'
        id column:'ejec__id'
        id generator:'identity'
        version false
        columns {
            asignacion column: 'asgn__id'
            sigef column:       'sigf__id'
            vigente column:    'ejecvgnt'
            compromiso column: 'ejeccmps'
            devengado column:  'ejecdvng'
            pagado column:     'ejecpgdo'
            saldoPresupuesto column: 'ejecslps'
            saldoDisponible  column: 'ejecslds'
        }
    }
    static constraints = {
/*
        fecha( blank:true, nullable:true ,attributes:[mensaje:'Fecha de ingreso'])
        mes(nullable: false,blank: false)
        anio(nullable: false,blank: false)
        asignacion(nullable: false,blank: false)
*/

    }
}