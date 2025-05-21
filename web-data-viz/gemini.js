const { GoogleGenAI } = require("@google/genai");

const chatIA = new GoogleGenAI({ apiKey: process.env.MINHA_CHAVE });

module.exports = chatIA;
