Data structure

{
  "slug": "chat-example",
  "title": "Ayer reprobé matemáticas, hagan sus preguntas",
  "accentColor": "#5865F2",
  "titleDurationMs": 4128,
  "titleAudioFile": "title.mp3",
  "background": "content/chat-example/video/1.mp4",
  "entries": [
    {
      "username": "MathLover99",
      "avatarEmoji": "🦊",
      "bubbleColor": "#5865F2",
      "question": "¿Cuánto es la derivada de x²?",
      "questionAudioFile": "question-0.mp3",
      "questionDurationMs": 2928,
      "answer": "La derivada de x al cuadrado es 2x. Es una de las reglas fundamentales del cálculo diferencial que se aprende en el primer curso.",
      "answerAudioFile": "answer-0.mp3",
      "answerDurationMs": 8856,
  "background": "content/chat-example/video/2.mp4"
    },
    {
      "username": "estudiante_raro",
      "avatarEmoji": "🐢",
      "bubbleColor": "#EB459E",
      "question": "¿Qué es un número irracional?",
      "questionAudioFile": "question-1.mp3",
      "questionDurationMs": 2376,
      "answer": "Un número irracional no puede expresarse como fracción de dos enteros. El ejemplo más famoso es π, que empieza por 3,14159 y no tiene patrón que se repita.",
      "answerAudioFile": "answer-1.mp3",
      "answerDurationMs": 12600,
  "background": "content/chat-example/video/1.mp4"
    },
    {
      "username": "profe_espía",
      "avatarEmoji": "🦉",
      "bubbleColor": "#57F287",
      "question": "¿Cómo se resuelve una ecuación de segundo grado?",
      "questionAudioFile": "question-2.mp3",
      "questionDurationMs": 3408,
      "answer": "Usas la fórmula cuadrática: x = (-b ± √(b²-4ac)) / 2a. Donde a, b y c son los coeficientes del polinomio ax² + bx + c = 0.",
      "answerAudioFile": "answer-2.mp3",
      "answerDurationMs": 10824,
  "background": "content/chat-example/video/2.mp4"

    }
  ]
}

import { z } from "zod";

// ─── Timeline schema (output of CLI, input to composition) ────────────────────

export const ChatEntryTimelineSchema = z.object({
  username: z.string(),
  avatarEmoji: z.string(),
  bubbleColor: z.string().optional(),
  question: z.string(),
  questionAudioFile: z.string().optional(),
  questionDurationMs: z.number(),
  answer: z.string(),
  answerAudioFile: z.string().optional(),
  answerDurationMs: z.number(),
  background: z.string().optional(),
});

export const ChatQATimelineSchema = z.object({
  slug: z.string(),
  title: z.string(),
  accentColor: z.string().default("#5865F2"),
  titleDurationMs: z.number().default(3000),
  titleAudioFile: z.string().optional(),
  background: z.string().optional(),
  entries: z.array(ChatEntryTimelineSchema),
});

export type ChatEntryTimeline = z.infer<typeof ChatEntryTimelineSchema>;
export type ChatQATimeline = z.infer<typeof ChatQATimelineSchema>;

// ─── Config schema (written by the user, consumed by CLI) ─────────────────────

export const ChatQAConfigSchema = z.object({
  slug: z.string(),
  title: z.string(),
  model: z.string().default("speaches-ai/Kokoro-82M-v1.0-ONNX"),
  voice: z.string().default("af_heart"),
  titleVoice: z.string().optional(),
  questionVoice: z.string().optional(),
  accentColor: z.string().default("#5865F2"),
  questionDisplayMs: z.number().default(2500),
  entries: z.array(
    z.object({
      username: z.string(),
      avatarEmoji: z.string(),
      bubbleColor: z.string().optional(),
      question: z.string(),
      questionVoice: z.string().optional(),
      background: z.string().optional(),
      answer: z.string(),
    }),
  ),
  background: z.string().optional(),
});

export type ChatQAConfig = z.infer<typeof ChatQAConfigSchema>;
