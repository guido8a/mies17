package mies

class Supuesto implements Serializable {
    MarcoLogico marcoLogico
    String descripcion
    ModificacionProyecto modificacion
    int estado = 0 /* 0 -> activo por facilidad en la base de datos  1-> modificado*/

    static auditable=[ignore:[]]
    static mapping = {
        table 'spst'
        cache usage:'read-write', include:'non-lazy'
        id column:'spst__id'
        id generator:'identity'
        version false
        columns {
            id column:'spst__id'
            marcoLogico column: 'mrlg__id'
            descripcion column: 'spstdscr'
            modificacion column: 'mdfc__id'
            estado column: 'spstetdo'
        }
    }
    static constraints = {
        marcoLogico( blank:true, nullable:true ,attributes:[mensaje:'Elemento del marco lógico al que se aplica el supuesto'])
        descripcion( blank:false, nullable:false ,attributes:[mensaje:'Descripción'])
        modificacion(blank: true,nullable: true)
        estado(blank:false,nullable: false)
    }

    String toString(){
        if(this?.descripcion?.size()>20){
            def partes = this?.descripcion?.split(" ")
            def cont=0
            def des =""
            partes.each {
                cont+=it.size()
                if(cont<22)
                    des+=" "+it
            }
            return des+"... "

        }else{
            return "${this?.descripcion}"
        }

    }
    String toStringCompleto(){
        return this.descripcion
    }
}