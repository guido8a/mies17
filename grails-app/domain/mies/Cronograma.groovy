package mies

class Cronograma implements Serializable {
    Cronograma cronograma
    Mes mes
    MarcoLogico marcoLogico
    Fuente fuente
    Anio anio
    ModificacionProyecto modificacionProyecto
    Presupuesto presupuesto
    Presupuesto presupuesto2
    double valor
    double valor2
    Date fechaInicio
    Date fechaFin
    static auditable=[ignore:[]]
    static mapping = {
        table 'crng'
        cache usage:'read-write', include:'non-lazy'
        id column:'crng__id'
        id generator:'identity'
        version false
        columns {
            id column:'crng__id'
            cronograma column: 'crngpdre'
            mes column: 'mess__id'
            marcoLogico column: 'mrlg__id'
            fuente column: 'fnte__id'
            anio column: 'anio__id'
            modificacionProyecto column: 'mdfc__id'
            presupuesto column: 'prsp__id'
            presupuesto2 column: 'prsp2_id'
            valor column: 'messvlor'
            valor2 column: 'mesvlor2'
            fechaInicio column: 'crngfcin'
            fechaFin column: 'crngfcfn'
        }
    }
    static constraints = {
        cronograma( blank:true, nullable:true ,attributes:[mensaje:'Cronograma original en el caso de haber modificaciones'])
        mes( blank:true, nullable:true ,attributes:[mensaje:'Mes'])
        marcoLogico( blank:true, nullable:true ,attributes:[mensaje:'Actividad del marco lógico'])
        fuente( blank:true, nullable:true ,attributes:[mensaje:'Fuente'])
        anio( blank:true, nullable:true ,attributes:[mensaje:'Año'])
        modificacionProyecto( blank:true, nullable:true ,attributes:[mensaje:'Modificación en base a la cual se crea el nuevo registro'])
        presupuesto(nullable: false,blank:false)
        presupuesto2(nullable: true,blank:true)
        valor( blank:true, nullable:true ,attributes:[mensaje:'Valor a ejecutarse en el mes'])
        valor2( blank:true, nullable:true ,attributes:[mensaje:'Valor a ejecutarse en el mes'])
        fechaInicio( blank:true, nullable:true ,attributes:[mensaje:'Fecha de inicio real de la actividad'])
        fechaFin( blank:true, nullable:true ,attributes:[mensaje:'Fecha de finalización real de la actividad'])
    }
}