---
layout: blog
title: codex概览
date: 2026-10-29 10:34:17
tags:
cover: 1.jpg
---

# LLM和Agent的区别

## LLM

1. 是什么
Large Language Model 即大语言模型
Deepseek、ChatGPT等等，都是LLM
工作原理是**预测下一个字**
2. 弊端
- 只会说不会做
- 上下文局限在本轮对话的窗口内，没有记忆
- 不会使用工具，所有知识来源于旧知识
- 被动响应，没法主动拆解任务

## Agent
1. 是什么
- 智能体，是LLM在循环中自主使用工具的系统
- Agent的核心大脑依然是大模型，具备调用外部工具的能力，且可以循环持续思考

2. 如何解决LLM的弊端
- 只会说不会做  **工具调用**：搜索引擎、数据库、API、代码执行器
- 上下文局限在本轮对话的窗口内，没有记忆  **记忆系统**：当前任务窗口上下文的短期记忆 + 外部数据库存储的长期记忆
- 不会使用工具，所有知识来源于旧知识  **MCP等标准化协议**：统一工具接入方式
- 被动响应，没法主动拆解任务  **任务拆解和规划能力**
3. 核心组成？
- 大脑：LLM
- 规划模块：Planning
- 记忆模块：Memory
- 工具模块：tools

# Agent和WorkFlow的区别
1. WorkFlow是LLM和工具通过预定义的代码路径进行编排的系统；Agent是LLM动态主导自身流程和工具调用逻辑的系统，由LLM自主决定任务如何完成
2. WorkFlow的token消耗量小、行为可预测、出了问题易定位，但灵活性差；Agent灵活、动态，但token消耗量大，调试起来更为困难
3. WorkFlow的控制权在代码手里，Agent的控制权在LLM手里
4. 现在大部分时候用的都是混合架构。金融系统、医疗系统等对可靠性要求高就用WorkFlow，开放式任务就用Agent


# Agent工作模式

1. React:思考-行动-观察
 * 透明化、可审计、适用性强，但token消耗量大
2. Plan-and-Execute:规划-执行
 * 节省，但不够灵活
3. Reflection:执行-自我检查-交付
 * 自我反省
 * 双Agent对话
4. Multi-Agent:多个专业化的Agent各司其职
   * 目前主流的多Agent框架：LangGraph\CrewAI\OpenAi Agents SDK\AutoGen
   
# Function Call - 工具调用能力的实现

## 工作原理

### 流程
1. 定义函数，用JSON格式描述每个函数的名字、功能说明和参数
如：
```
{
  "tools": [
    {
      "type": "function",
      "function": {
        "name": "get_weather",
        "description": "获取指定城市的实时天气",
        "parameters": {
          "type": "object",
          "properties": {
            "city": {
              "type": "string", 
              "description": "城市名称，比如：上海"
            }
          },
          "required": ["city"]
        }
      }
    }
  ]
}
```
2. 模型判断：
模型根据用户提问内容，判断要调用哪个函数，并生成参数：
```
{
  "tool_calls": [
    {
      "type": "function",
      "function": {
        "name": "get_weather",
        "arguments": "{\"city\": \"上海\"}"
      }
    }
  ]
}
```
3. 执行函数：是应用程序而不是LLM自己执行函数
4. 生成回答

### 意义
- LLM可以自己推理**什么时候调用**
- LLM可以自己从用户的提问中提取**传什么参数**
- **可以说，Function Call就是Agent能力的最底层技术基础
- Function Call是Agent的原子操作，Agent是Function Call的高级编排。一个复杂任务可能需要连续进行十几次Function Call

# MCP
Model Context Protocol

## MCP怎么工作的？

### MCP架构
1. MCP Host AI应用
2. MCP Client 客户端 在Host里面负责跟MCP通信
3. MCP Server 服务端 负责对外暴露工作能力、数据资源

# Skills

# Function Call、MCP、skills综述

Function Call是一种API协议，在应用程序中执行；MCP是一种通信协议，在外部的MCP server中执行；Skills是一种提示词拓展，在上下文窗口内使用

# A2A
 Agent间通信（Agent2Agent）

## 概念
Agent Card
Task
Message & Artifact

## 技术特点

1. 完全基于现有的Web标准：HTTP用于传输、JSON用于消息格式、SSE用于实时流式通信
2. 支持异步和长时间运行的任务（任务状态查询、进度更新、断线重连）
3. 模态无关（文本、音频、图像、结构化数据等等都可以支持）



