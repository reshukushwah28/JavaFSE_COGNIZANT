package com.library.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

/**
 * Aspect logging class containing ONLY the execution time logger.
 * Annotated with @Aspect to identify it as a cross-cutting module.
 */
@Aspect
public class LoggingAspect {

    
    @Around("execution(* com.library.service.BookService.*(..))")
    public Object logExecutionTime(ProceedingJoinPoint joinPoint) throws Throwable {
        long startTime = System.currentTimeMillis();
        
        
        Object proceedResult = joinPoint.proceed();
        
        long endTime = System.currentTimeMillis();
        long executionTime = endTime - startTime;
        
        System.out.println("[AOP TIMER] Method '" + joinPoint.getSignature().getName() 
                           + "' completed execution in " + executionTime + " ms.");
        
        return proceedResult;
    }
}

