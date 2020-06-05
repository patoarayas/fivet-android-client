/*
 * MIT License
 *
 * Copyright (c) 2020 Patricio Araya González <patricio.araya@alumnos.ucn.cl>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

// https://doc.zeroc.com/ice/3.7/language-mappings/java-mapping/client-side-slice-to-java-mapping/customizing-the-java-mapping
["java:package:cl.ucn.disc.pdis.fivet.zeroice", "cs:namespace:Fivet.ZeroIce"]
module model {

   /// Fechas ISO_ZONED_DATE_TIME

     /**
     * Persona
     */
     ["cs:property"]
     class Persona{

        /** Identificador Numérico*/
        int uid;
        /** Rut */
        string rut;
        /** Nombre */
        string nombre;
        /** Direccion */
        string direccion;
        /** Telefono */
        long telefono;
        /** Número télefono celular */
        long celular;
        /** email */
        string email;

     }
     /** Tipo de paciente */
     enum TipoPaciente {INTERNO,EXTERNO}
     /** Sexo paciente **/
     enum Sexo {MACHO,HEMBRA}

     /**
     *  Ficha de paciente
     */
     ["cs:property"]
     class Ficha {

         /** Identificador numérico */
         int uid;
         /** Numero de registro */
         int numeroRegistro;
         /** Nombre */
         string nombre;
         /** Especie */
         string especie;
         /** Fecha de nacimiento */
         string fechaNacimiento;
         /** Raza */
         string raza;
         /** Sexo */
         Sexo sexo;
         /** Color */
         string color;
         /** Tipo */
         TipoPaciente tipo;
         /** URL foto perfil */
         string fotoPerfil;
         /** Fotos del paciente */
         // FIXME: Syntax error?
         //sequence<string> fotos;

     }

     /**
     * Control del paciente
     */
     ["cs:property"]
     class Control{

        /** Id */
        int uid;
        /** Fecha */
        string fechaControl;
        /** Fecha proximo control */
        string fechaProximoControl;
        /** Temperatura */
        double temperatura;
        /** Peso */
        double peso;
        /** Altura */
        double altura;
        /** Diagnostico */
        string diagnostico;
        /** Nombre veterinario */
        string veterinario;
        /** Examenes correspondientes al control */
        // FIXME: Syntax error?
        //sequence<Examen> examenes;

     }

     class Examen {
        /** Nombre examen */
        string nombreExamen;
        /** Fecha examen **/
        string fechaExamen;
     }

     /**
     * Sistema base
     */
     interface Sistema {

        /**
         * @return the diference in time between client and server.
         */
        long getDelay(long clientTime);

     }

     /**
     * Contratos del sistema
     */
     interface Contratos {

        /**
        * Crea una ficha para un paciente
        * @param ficha: Ficha del paceinte a crear
        * @return Ficha creada
        */
        Ficha crearFicha(Ficha ficha);

        /** Crear persona (dueño)
        * @param persona: Persona a ser creada
        * @return Persona creada
        */
        Persona crearPersona(Persona persona);

        /** 
        * Añadir un control
        * @param numeroFicha: Numero ficha 
        * @param control: Control a ser creado
        * @return Control creado
        */
        Control crearControl(int numeroFicha, Control control);

        /**
        * Obtener Ficha
        * @param numeroFicha: numero de ficha del paciente
        * @return Ficha del paciente
        */
        Ficha obtenerFicha(int numeroFicha);

        /**
        * Obtener Persona
        * @param rut: Rut de la persona
        * @return Persona
        */
        Persona obtenerPersonaPorRut(string rut);

        /**
        * Buscar una ficha por número, nombre o rut
        * @param key : Llave por la cual buscar
        * @return Ficha del paciente
        * TODO: En el caso de que sea por nombre debe retornar secuencia de fichas.
        */
        // FichaPaciente buscarFichaPorRut(string key);

        /**
        * Agrega un control a una ficha
        * @param numeroFicha : El numero de ficha
        * @param control : El control a agregar
        */
        // bool agregarControl(int numeroFicha, Control control);

        /** Crear un carnet de paciente
        * @param ficha : La ficha del paciente
        * TODO: Que significa el carnet de paciente?
        */
        // bool crearCarnetPaciente(FichaPaciente ficha);

        /** Agregar foto del paciente
        * @param numeroFicha : Id del paciente
        * @param urlFoto : Direccion de la foto
        */
        // bool agregarFoto(int numeroFicha, string urlFoto);

     }
}
