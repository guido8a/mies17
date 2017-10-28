package mies

class ProgramacionAsignacion implements Serializable {
    Asignacion asignacion
    DistribucionAsignacion distribucion
    Mes mes
    ProgramacionAsignacion padre
    ModificacionProyecto modificacion
    Cronograma cronograma
    double valor
    int estado=0

    static auditable=[ignore:[]]

    static mapping = {
        table 'pras'
        cache usage:'read-write', include:'non-lazy'
        id column:'pras__id'
        id generator:'identity'
        version false
        columns {
            id column:'pras__id'
            asignacion column: 'asgn__id'
            distribucion column: 'dsas__id'
            mes column: 'mess__id'
            padre column: 'praspdre'
            modificacion column: 'mdfc__id'
            valor column: 'messvlor'
            estado column: 'prasetdo'
            cronograma column: 'crng__id'

        }
    }
    static constraints = {
        asignacion( blank:true, nullable:true ,attributes:[mensaje:'Asignación'])
        distribucion(blank:true,nullable: true)
        mes( blank:false, nullable:false ,attributes:[mensaje:'Cuatrimestre'])
        padre( blank:true, nullable:true ,attributes:[mensaje:'Asignación original en base a la cual se registra la actual modificada'])
        modificacion( blank:true, nullable:true ,attributes:[mensaje:'Modificación en base a la cual se crea la nueva'])
        valor( blank:true, nullable:true ,attributes:[mensaje:'Valor asignado al cuatrimestre'])
        estado(blank:false, nullable:false ,attributes:[mensaje:'estado de la asignación'])
        cronograma(blank:true,nullable: true)
    }
}