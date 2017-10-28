package mies

class Meta implements Serializable {
    TipoMeta tipoMeta
    Parroquia parroquia
    MarcoLogico marcoLogico
    Unidad unidad
    Anio anio
    String descripcion
    double indicador
    double inversion
    int cord_x =0
    int cord_y =0
    ModificacionProyecto modificacion
    int estado = 0 /* 0 -> activo por facilidad en la base de datos  1-> modificado*/
    static auditable=[ignore:[]]
    static mapping = {
        table 'meta'
        cache usage:'read-write', include:'non-lazy'
        id column:'meta__id'
        id generator:'identity'
        version false
        columns {
            id column:'meta__id'
            tipoMeta column: 'tpmt__id'
            parroquia column: 'parr__id'
            marcoLogico column: 'mrlg__id'
            unidad column: 'undd__id'
            descripcion column: 'mcacdscr'
            indicador column: 'metaindi'
            cord_x column: 'metacrdx'
            cord_y column: 'metacrdy'
            modificacion column: 'mdfc__id'
            estado column: 'metaetdo'
            inversion column: 'metainvs'
            anio column: 'anio__id'
        }
    }
    static constraints = {
        tipoMeta( blank:true, nullable:true ,attributes:[mensaje:'Tipo de Meta'])
        parroquia( blank:false, nullable:false ,attributes:[mensaje:'Parroquia en la cual se verificará la meta'])
        marcoLogico( blank:true, nullable:true ,attributes:[mensaje:'Componente del marco lógico'])
        unidad( blank:true, nullable:true ,attributes:[mensaje:'Unidad de medida'])
        descripcion(size:1..1024, blank:true, nullable:true ,attributes:[mensaje:'Descripción de la meta a alcanzar'])
        indicador( blank:true, nullable:true ,attributes:[mensaje:'Indicador numérico de la meta'])
        modificacion(blank: true,nullable: true)
        estado(nullable: false,blank: false)
    }

//    String toString(){
//        if(descripcion.size()>20){
//            def partes = descripcion.split(" ")
//            def cont=0
//            def des =""
//            partes.each {
//              cont+=it.size()
//                if(cont<22)
//                des+=" "+it
//            }
//            return des+"... "
//
//        }else{
//            return "${this.descripcion}"
//        }
//
//    }
}