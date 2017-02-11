module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    beginnerProgram { view = view, update = update, model = model }



-- model


type alias Model =
    { todo : String
    , todos : List String
    }


model : Model
model =
    { todo = ""
    , todos = []
    }



-- update


stylesheet =
    let
        tag =
            "link"

        attrs =
            [ attribute "Rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" "https://maxcdn.boostrapcdn.com/boostrap/3.3.7/css/boostrap.min.css"
            ]

        children =
            []
    in
        node tag attrs children


type Msg
    = UpdateTodo String
    | AddTodo
    | RemoveAll
    | RemoveItem String


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateTodo text ->
            { model | todo = text }

        AddTodo ->
            { model | todos = model.todo :: model.todos, todo = "" }

        RemoveAll ->
            { model | todos = [] }

        RemoveItem text ->
            { model | todos = List.filter (\x -> x /= text) model.todos }



-- view


todoItem : String -> Html Msg
todoItem todo =
    li [] [ text todo, button [ onClick (RemoveItem todo) ] [ text "x" ] ]


todoList : List String -> Html Msg
todoList todos =
    let
        child =
            List.map todoItem todos
    in
        ul [] child


view : Model -> Html Msg
view model =
    div
        [ class "jumbotron"
        ]
        [ stylesheet
        , input
            [ type_ "text"
            , onInput UpdateTodo
            , value model.todo
            , class "form-control"
            ]
            []
        , button
            [ onClick AddTodo, class "btn btn-primary" ]
            [ text "Submit" ]
        , button
            [ onClick RemoveAll, class "btn btn-danger" ]
            [ text "Remove All" ]
        , div
            []
            [ todoList model.todos ]
        ]
