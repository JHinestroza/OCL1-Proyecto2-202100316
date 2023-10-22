import React, { useState, useRef } from "react";
import Editor from '@monaco-editor/react';
import './Stilos.css';
import service from "../services/service";

function AreaTexto(props) {
    const [value, setValue] = useState("")
    const [response, setResponse] = useState("")
    const [cols, setCols] = useState(["ID", "ERROR", "MENSAJE"])
    const [index, setIndex] = useState(0)
    const [tuplas, setTuplas] = useState([["0", "Semantico", "error semantico"], ["1", "Sintactico", "error sintactico"]])

    const changeText = (valueA) => {
        setValue(valueA)
    }

    const handlerPostParse = () => {
        service.parse(value)
            .then(({ consola }) => {
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
        setIndex(index + 1)
    }

    const handleShowText = () => {
        service.ping();// Mostrar el texto capturado en un aviso
    }

    const handlerChangeEditor = (evt) => {
        props.handlerChange(evt.target.value)
    }
    

    return (
        <>
            <div className="container">
                <div class="column">
                    <h2>Entrada</h2>

                    <Editor
                        height="45vh"
                        language="javascript"
                        theme="vs-dark"
                        text={"Consola Entrada"}
                        handlerChange={changeText}



                    />
                    <button type="button" class="btn btn-outline-success" onClick={handlerPostParse}>Traducir</button>
                </div>
                <div class="column">
                    <h2>Salida</h2>
                    <Editor
                        height="45vh"
                        language="sql" // Puedes ajustar el lenguaje según tus necesidades
                        theme="vs-dark" // Tema del editor
                        readOnly={true} // Evita que el usuario edite el código de salida
                        onChange={handlerChangeEditor} value={props.value}
                    />
                    {props.comp}
                </div>

            </div>
        </>

    )
}

export default AreaTexto;
