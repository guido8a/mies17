package mies

class MedioVerificacion implements Serializable {
    Indicador indicador
    String descripcion
    ModificacionProyecto modificacion
    int estado = 0 /* 0 -> activo por facilidad en la base de datos  1-> modificado*/
    static auditable=[ignore:[]]
    static mapping = {
        table 'mdvf'
        cache usage:'read-write', include:'non-lazy'
        id column:'mdvf__id'
        id generator:'identity'
        version false
        columns {
            id column:'mdvf__id'
            indicador column: 'indi__id'
            descripcion column: 'indidscr'
            modificacion column: 'mdfc__id'
            estado column: 'mdvfetdo'
        }
    }
    static constraints = {
        indicador( blank:false, nullable:false ,attributes:[mensaje:'Elemento del marco lógico al que se aplica el indicador'])
        descripcion(size:1..1023, blank:false, nullable:false ,attributes:[mensaje:'Descripción del medio de verificación'])
        modificacion(blank: true,nullable: true)
        estado(blank:false,nullable: false)
    }

    String toString(){
        if(descripcion.size()>20){
            def partes = descripcion.split(" ")
            def cont=0
            def des =""
            partes.each {
                cont+=it.size()
                if(cont<22)
                    des+=" "+it
            }
            return des+"... "

        }else{
            return "${this.descripcion}"
        }

    }
    String toStringCompleto(){
        return this.descripcion
    }

}