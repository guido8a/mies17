package mies

class Modificables {

    ModificacionProyecto modificacion
    int tipo /* 1 fin    2 proposito     3 indicador     4 meta     5 supuesto      6 actividad     7 medio de verificacion    8 componentes  */
    int id_remoto
    Date fecha

    static auditable=[ignore:[]]
    static mapping = {
        table 'mdcb'
        cache usage:'read-write', include:'non-lazy'
        id column:'mdcb__id'
        id generator:'identity'
        version false
        columns {
            id column:'mdcb__id'
            modificacion column: 'mdfc__id'
            tipo  column: 'mdcbtipo'
            id_remoto column: 'mdcbidrm'
            fecha column: 'mdcbfcha'
        }
    }
    static constraints = {
        modificacion(blank: false,nullable: false)
        tipo(blank: false,nullable: false)
        id_remoto(blank: false,nullable: false)
        fecha(blank: true,nullable: true)
    }
    String toString(){
        "${this.tipo}:${id_remoto}"
    }
}
