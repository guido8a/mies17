package mies

class ModificacionTechos {
    
    PresupuestoUnidad desde
    PresupuestoUnidad recibe
    int tipo /*  1-> corriente a corriente    2-> corriente a inversion  3-> eliminar asignacion */
    double valor
    Date fecha
    mies.seguridad.Usro usuario


    static auditable=[ignore:[]]
    static mapping = {
        table 'mdtc'
        cache usage:'read-write', include:'non-lazy'
        id column:'mdtc__id'
        id generator:'identity'
        version false
        columns {
            id column:'mdtc__id'
            desde column: 'pruedsde'
            recibe column: 'pruercbe'
            fecha column: 'mdasfcha'
            valor column: 'mdasvlor'
            usuario column: 'usro__id'
            tipo column: 'mdtctipo'
        }
    }
    static constraints = {
        desde( blank:true, nullable:true ,attributes:[mensaje:'Asignación desde donde sale dinero'])
        recibe( blank:true, nullable:true ,attributes:[mensaje:'Asignación que recibe el dinero'])
        fecha( blank:true, nullable:true ,attributes:[mensaje:'Fecha'])
        valor( blank:true, nullable:true ,attributes:[mensaje:'Valor redistribuido, siempre en positivo'])
        usuario(blank:false,nullable: false)
    }
}
