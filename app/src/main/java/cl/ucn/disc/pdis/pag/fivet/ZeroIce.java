/*
 * Copyright (c) 2020.  Patricio Araya González
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 *  without restriction, including without limitation the rights to use, copy, modify, merge,
 *  publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 *  to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 *  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 *  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 *  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 *  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 *  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package cl.ucn.disc.pdis.pag.fivet;

import com.zeroc.Ice.Communicator;
import com.zeroc.Ice.InitializationData;
import com.zeroc.Ice.ObjectPrx;
import com.zeroc.Ice.Properties;
import com.zeroc.Ice.Util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cl.ucn.disc.pdis.fivet.zeroice.model.Contratos;
import cl.ucn.disc.pdis.fivet.zeroice.model.ContratosPrx;

public final class ZeroIce {

    // Logger
    private static final Logger log = LoggerFactory.getLogger(ZeroIce.class);

    // Singleton instance
    private static final ZeroIce ZERO_ICE = new ZeroIce();

    // Communicator
    private Communicator communicator;

    // ContratosImpl
    private ContratosPrx contratosPrx;

    // Empty constructor
    private ZeroIce(){

    }

    /**
     * Get singleton method
     * @return ZeroIce instance
     */
    public static ZeroIce getInstance(){
        return ZERO_ICE;
    }

    /**
     * @param args to use as source.
     * @return the {@link InitializationData}.
     */
    private static InitializationData getInitializationData(String[] args) {

        // Properties
        final Properties properties = Util.createProperties(args);
        properties.setProperty("Ice.Package.model", "cl.ucn.disc.pdis.fivet.zeroice");

        // https://doc.zeroc.com/ice/latest/property-reference/ice-trace
        // properties.setProperty("Ice.Trace.Admin.Properties", "1");
        // properties.setProperty("Ice.Trace.Locator", "2");
        // properties.setProperty("Ice.Trace.Network", "3");
        // properties.setProperty("Ice.Trace.Protocol", "1");
        // properties.setProperty("Ice.Trace.Slicing", "1");
        // properties.setProperty("Ice.Trace.ThreadPool", "1");
        // properties.setProperty("Ice.Compression.Level", "9");
        properties.setProperty("Ice.Plugin.Slf4jLogger.java", "cl.ucn.disc.pdis.fivet.zeroice.Slf4jLoggerPluginFactory");

        InitializationData initializationData = new InitializationData();
        initializationData.properties = properties;

        return initializationData;
    }

    /**
     * Start communication
     */
    public void start(){
        if(this.communicator != null){
            log.warn("Communicator was already initialized");
            return;
        }
        this.communicator = Util.initialize(getInitializationData(new String[1]));
        String name = Contratos.class.getSimpleName();
        log.debug("Proxy <{}>", name);
        ObjectPrx proxy = this.communicator.stringToProxy(name + ":tcp -z -t 15000 -p 8080");
        this.contratosPrx = ContratosPrx.checkedCast(proxy);
    }

    /**
     * Stop communication
     */
    public void stop(){
        if(this.communicator == null){
            log.warn("Communicator already stopped");
            return;
        }
        this.contratosPrx = null;
        this.communicator.destroy();
    }
}
