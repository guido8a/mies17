package mies

class Indicador implements Serializable {
    MarcoLogico marcoLogico
    String descripcion
    double cantidad
    ModificacionProyecto modificacion
    int estado = 0 /* 0 -> activo por facilidad en la base de datos  1-> modificado*/
    static auditable=[ignore:[]]
    static mapping = {
        table 'indi'
        cache usage:'read-write', include:'non-lazy'
        id column:'indi__id'
        id generator:'identity'
        version false
        columns {
            id column:'indi__id'
            marcoLogico column: 'mrlg__id'
            descripcion column: 'indidscr'
            cantidad column: 'indicntd'
            modificacion column: 'mdfc__id'
            estado column: 'indietdo'
        }
    }
    static constraints = {
        marcoLogico( blank:false, nullable:false ,attributes:[mensaje:'Elemento del marco lógico al que se aplica el indicador'])
        descripcion(size:1..1023, blank:true, nullable:true ,attributes:[mensaje:'Descripción del indicador'])
        cantidad( blank:true, nullable:true ,attributes:[mensaje:'Cantidad para indicadores cuantitativos'])
        modificacion(blank: true,nullable: true)
        estado(nullable: false,blank: false)
    }
     String toString(){
        "${this.descripcion}"
    }

}