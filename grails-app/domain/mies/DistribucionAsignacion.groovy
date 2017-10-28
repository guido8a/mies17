package mies

class DistribucionAsignacion {

    Asignacion asignacion
    double valor = 0
    UnidadEjecutora unidadEjecutora


    static auditable=[ignore:[]]
    static mapping = {
        table 'dsas'
        cache usage:'read-write', include:'non-lazy'
        id column:'dsas__id'
        id generator:'identity'
        version false
        columns {
            id column:'dsas__id'
            asignacion column: 'asgn__id'
            valor column: 'dsasvlor'
            unidadEjecutora column: 'unej__id'
        }
    }
    static constraints = {

    }

    String toString(){
        "${this.unidadEjecutora} ${this.valor}"
    }


    def getValorReal(){
        def hijos = Asignacion.findAllByPadreAndUnidad(this.asignacion,this.unidadEjecutora)
       // println " asgn  "+this.asignacion.id
        def val=0
        hijos.each {
            val += getValorHijo(it)
        }
        return this.valor - val
        
    }

    def getValorHijo(asg){
       // println "get valor hijo "+asg.id
        def hijos = Asignacion.findAllByPadre(asg)
        //println "hijos "+hijos
        def val=0
        hijos.each {
            val += getValorHijo(it)
        }
       // println "return "+(val+asg.planificado)
        return val+asg.planificado
    }


}
