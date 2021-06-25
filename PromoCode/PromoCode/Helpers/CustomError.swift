//
//  CustomError.swift
//  PromoCode
//
//  Created by Дарья on 25.06.2021.
//

import Foundation

enum СustomError: String, Error {
    case emptyInput = "Пожалуйста, заполните все поля 👉👈"
    case differentPasswords = "Вы ввели разные пароли 😔"
    case incorrectPassword = "Пароль должен содержать хотя бы 6 символа 🙏"
    
    case error = "Ошика ☹️"
    case unexpected = "Неизвестная ошибка 🤔"
    case noSignedUser = "Пользователь не авторизирован 🤷‍♀️"
    case noUser = "Неверный логин или пароль 🤔"
    case failedToCreateUser = "Эта почта уже занята или некорректна 🤷‍♀️"
    case failedToSaveUserInFireStore = "Не удалось сохранить данные пользователя 😥"
    case failedToDelete = "Не удалось удалить 🤷‍♀️"
    case failedToSignOut = "Не удалось выйти из аккаунта 🤷‍♀️"
}
