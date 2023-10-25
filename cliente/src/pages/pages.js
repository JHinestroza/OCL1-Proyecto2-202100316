import React, { useState } from "react";
import Navbar from "../components/navbar";
import Editor from "../components/textarea";
import service from '../services/service'

function Index() {
    const [ value, setValue ] = useState("")
    const [ response, setResponse ] = useState("")
    const [ cols, setCols ] = useState(["ID", "ERROR", "MENSAJE"])
    const [ index, setIndex ] = useState(0) 
    const [ tuplas, setTuplas ] = useState([["0", "Semantico", "error semantico"], ["1", "Sintactico", "error sintactico"]])

    const changeText = (valueA) => {
        setValue(valueA)
    }

    const handlerPostParse = () => {
        service.parse(value)
        .then(({consola}) => {
            setResponse(consola)
        })
    }

    const handlerGetServerInfo = () => {
        service.ping()
        .then((response) => {
            setResponse(JSON.stringify(response))
        })
    }

    const handlerClear = () => {
        setResponse("")
    }

    const handlerAdd = () => {
        const newTuplas = [...tuplas, [index, `registro ${index}`, `mensaje ${index}`]]
        setTuplas(newTuplas)
        setIndex(index+1)
    }

    const buttonTraducir = <button type="button" class="btn btn-outline-success" onClick={handlerPostParse}>Traducir</button>
    const buttonLimpiar = <button type="button" class="btn btn-outline-danger" onClick={handlerClear}>Limpiar</button>
    return (
        <>
            <Navbar />
            
            <Editor text={"Consola Entrada"} handlerChange={changeText} rows={10} comp = {buttonTraducir}/>
            <Editor text={"Consola Salida"} value={response} rows={10} comp = {buttonLimpiar}/>
        </>
    )
}

export default Index;